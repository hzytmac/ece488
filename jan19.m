clear all;
clear;
clc

A=[-2 1;0 -2];
B=[0 1];
C=[1 1];
eqn=@(t,x)A*x+B;
dt=0.01;
x0=[0;0];

k1=