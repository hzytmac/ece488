close all;
clear;
clc;
s=tf('s');

A=[0 1;
    -2 -2];
B=[1; 0];
K = place(A,B,[-1 -2]);