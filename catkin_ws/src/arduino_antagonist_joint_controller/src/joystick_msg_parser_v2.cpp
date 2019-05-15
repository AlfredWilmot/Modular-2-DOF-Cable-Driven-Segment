#include "ros/ros.h"
#include "sensor_msgs/Joy.h"
#include "std_msgs/UInt16MultiArray.h"
#include "std_msgs/UInt8.h"
#include "std_msgs/Bool.h"
#include "string.h"

#include <iostream>
#include <unistd.h>

/*------------------------*/
/* Function declarations */
/*----------------------*/

//Subscriber callback for Open-Loop control
void OL_control(const sensor_msgs::JoyConstPtr& msg);

// Functions to directly control joint using D-pad & co-contract with left-trigger.
void proximal_joint_cmds(const sensor_msgs::JoyConstPtr msg);
void distal_joint_cmds(const sensor_msgs::JoyConstPtr msg);

// Prevent duplicate control packets from being sent to MCU, and also prevents expired packages from persisting.
int filter_duplicate_packets();

/*------------*/
/* motor msg */
/*----------*/

static std_msgs::UInt16MultiArray motor_packet;
static std_msgs::UInt16MultiArray previous_motor_packet;

static int packet_length = 12; // packet is 8 elements long (two per motor in single segment) + 4 motor-duty values.

/* motor msg publisher */
static ros::Publisher motor_pub;


/*-----------------------------------------*/
/* defining gamepad button/ axis indicies */
/*---------------------------------------*/

// AXIS (-1.0, 1.0):
const int d_pad_up_down         = 7; // U = +1.0, D = -1.0
const int d_pad_left_right      = 6; // L = +1.0, R = -1.0
const int right_trigger         = 5; // UnPressed = -1.0, Pressed = +1.0 (initial value, before ever being pressed, will show as 0.0)
const int right_joy_up_down     = 4; // U = +1.0, D = -1.0
const int right_joy_left_right  = 3; // L = +1.0, R = -1.0
const int left_trigger          = 2; // UnPressed = -1.0, Pressed = +1.0 (initial value, before ever being pressed, will show as 0.0)   
const int left_joy_up_down      = 1; // U = +1.0, D = -1.0
const int left_joy_left_right   = 0; // L = +1.0, R = -1.0

// BUTTONS (default 0, pressed 1):
const int press_right_joy   = 10;
const int press_left_joy    = 9;
const int xbox_btn          = 8;
const int start_btn         = 7;
const int back_btn          = 6;
const int RB_btn            = 5;
const int LB_btn            = 4;
const int Y_btn             = 3;
const int X_btn             = 2;
const int B_btn             = 1;
const int A_btn             = 0;



/*--------------------------------------------*/
/* global variables for the joint controller */
/*------------------------------------------*/

// Encoder values.
static int proximal_joint_value;
static int distal_joint_value;

// I-sense values.
static int proximal_motorA_load;
static int proximal_motorB_load;
static int distal_motorA_load;
static int distal_motorB_load;


/* Subscribe to the xbox-360 joy-stick topic, 
   publish corresponding motor control msg to "/segment_motor_cmds" topic */
int main(int argc, char **argv)
{
    /* Initializing motor packet*/ 
    motor_packet.data.clear();
    previous_motor_packet.data.clear();



    for(int i = 0; i < packet_length; i++)
    {
        motor_packet.data.push_back(0);     // Initialized packet with zero-value.
        previous_motor_packet.data.push_back(0);
    }

    /* ROS Node Premable */
    ros::init(argc, argv, "joystick_msg_parser");
    ros::NodeHandle nh;

    /* Subscribe to gamepad /joy topic */
    ros::Subscriber sub = nh.subscribe("joy", 1, OL_control);
   
   
    /* Publish filtered joy-msg into binary values that will be allocated by MCU as digital pin output states (thereby controlling motor direction) */
    motor_pub = nh.advertise<std_msgs::UInt16MultiArray>("segment_motor_cmds", 1);

    /* Service any subscriber callbacks (publishing parsed data takes place within callback) */
    ros::spin();

    return 0;
}



/* Define Proximal joint movement */
void proximal_joint_cmds(const sensor_msgs::JoyConstPtr msg)
{

    if(msg->axes[d_pad_up_down] == 1.0)
    {
        //proximal joint: up
        motor_packet.data.at(4) = 1;
        motor_packet.data.at(5) = 0;
        motor_packet.data.at(6) = 1;
        motor_packet.data.at(7) = 0;

        //Co-contract if trigger is pressed 
        if(msg->axes[left_trigger] < 0.0)
        {
            motor_packet.data.at(4) = 0;
            motor_packet.data.at(5) = 1;
        }
        //Co-release if right trigger is pressed 
        else if(msg->axes[right_trigger] < 0.0)
        {
            motor_packet.data.at(0) = 0;
            motor_packet.data.at(1) = 1;
        }

    }
    else if(msg->axes[d_pad_up_down] == -1.0)
    {
        //proximal joint: down
        motor_packet.data.at(4) = 0;
        motor_packet.data.at(5) = 1;
        motor_packet.data.at(6) = 0;
        motor_packet.data.at(7) = 1;

        //Co-contract if trigger is pressed 
        if(msg->axes[left_trigger] < 0.0)
        {
            motor_packet.data.at(6) = 1;
            motor_packet.data.at(7) = 0;  
        }
        //Co-release if right trigger is pressed 
        else if(msg->axes[right_trigger] < 0.0)
        {
            motor_packet.data.at(4) = 1;
            motor_packet.data.at(5) = 0;
        }
    }
    else
    {
        //Brake motor if D-pad is not pressed 
        motor_packet.data.at(4) = 0;
        motor_packet.data.at(5) = 0;
        motor_packet.data.at(6) = 0;
        motor_packet.data.at(7) = 0;         
    }
}

/* Define Distal joint movement */
void distal_joint_cmds(const sensor_msgs::JoyConstPtr msg)
{

    if(msg->axes[d_pad_left_right] == 1.0)
    {
        //distal_joint: left
        motor_packet.data.at(0) = 1;
        motor_packet.data.at(1) = 0;
        motor_packet.data.at(2) = 1;
        motor_packet.data.at(3) = 0;

        //Co-contract if left trigger is pressed 
        if(msg->axes[left_trigger] < 0.0)
        {
            motor_packet.data.at(0) = 0;
            motor_packet.data.at(1) = 1;
        }
        //Co-release if right trigger is pressed 
        else if(msg->axes[right_trigger] < 0.0)
        {
            motor_packet.data.at(2) = 0;
            motor_packet.data.at(3) = 1;
        }

    }
    else if(msg->axes[d_pad_left_right] == -1.0)
    {
        //distal joint: right
        motor_packet.data.at(0) = 0;
        motor_packet.data.at(1) = 1;
        motor_packet.data.at(2) = 0;
        motor_packet.data.at(3) = 1;

        //Co-contract if trigger is pressed 
        if(msg->axes[left_trigger] < 0.0)
        {
            motor_packet.data.at(2) = 1;
            motor_packet.data.at(3) = 0;  
        }
        //Co-release if right trigger is pressed 
        else if(msg->axes[right_trigger] < 0.0)
        {
            motor_packet.data.at(0) = 1;
            motor_packet.data.at(1) = 0;
        }
    }
    else
    {
        //Brake motor if D-pad is not pressed 

        motor_packet.data.at(0) = 0;
        motor_packet.data.at(1) = 0;
        motor_packet.data.at(2) = 0;
        motor_packet.data.at(3) = 0;   
    }
}


/* Filtering out duplicate joy messages */
int filter_duplicate_packets()
{
    bool is_not_duplicate_packet = false;

    for(int i=0; i<packet_length; i++)
    {   
        // if any of the new packet elements are different to the previous corresponding packet element, then update the old packet and set flag.
        if(previous_motor_packet.data.at(i) != motor_packet.data.at(i))
        {
            is_not_duplicate_packet = true;
            previous_motor_packet.data.at(i) = motor_packet.data.at(i);
        }
    }

    // Only Publish the assemlbed motor-control data-packet if it is different from the previous one.
    if(is_not_duplicate_packet)
    {
        return 0; // indicates new packet is not a dulicate.
    }
    else
    {
        return -1;  // indicates packet is a duplicate!
    }
       
}

/* A controller that uses Right-joyStick, as well as LT & RT for tension control of either joint */
void OL_control(const sensor_msgs::JoyConstPtr& msg)
{   
    // Control joints with D-pad (& left trigger)
    proximal_joint_cmds(msg);
    distal_joint_cmds(msg);
    
    // set each motor duty to 80% for OL testing (255 = 100%)
    motor_packet.data.at(8)  = 204;
    motor_packet.data.at(9)  = 204;
    motor_packet.data.at(10) = 204;
    motor_packet.data.at(11) = 204;

    // Keep it clean!
    if(filter_duplicate_packets() == 0)
    {
        motor_pub.publish(motor_packet);
    }
}


// TODO:

// -> Use a gamepad btn to cycle throught co-contractions (adjusts I-sense threshold)

// NOTES:
// -> Idle I-sense reading (no I-draw) ~ 580
// -> Define arbitrary ranges for three distinct co-contraction values:
//      * 500
//      * 350
//      * 200



// Can only detect torque values when driving motor

void CL_control(const sensor_msgs::Joy& msg)
{
    /* Sanity test 1: "Hold initial position" */

    // -> Sample the current joint angle.
    // -> If the joint is perturbed, drive the motors such that the joint is verged to.
    // -> Only use I-sense data to prevent over-loading the motors (identify an absoulte value for this).
    // -> Fitler noise/ transients in I-sense data by ignoring values that massively deveiate from the previous value (hysteresis band).


}