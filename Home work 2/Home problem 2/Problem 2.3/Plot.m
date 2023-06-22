function Plot(horizontalDistanceList, alphaList, pressureList, gearList, velocityList, tempBList, horizontalDistanceGearList)

subplot(5,1,1);
plot(horizontalDistanceList,alphaList,"Linewidth",1.5)
ylabel("\alpha (deg)")

subplot(5,1,2);
plot(horizontalDistanceList,pressureList,"Linewidth",1.5)
ylabel("Pressure")

subplot(5,1,3);
plot(horizontalDistanceGearList,gearList,"Linewidth",1.5)
ylabel("Gear")

subplot(5,1,4)
plot(horizontalDistanceList,velocityList,"Linewidth",1.5)
ylabel("v (m/s)")

subplot(5,1,5);
plot(horizontalDistanceList,tempBList,"Linewidth",1.5)
ylabel("T_b (K)")
xlabel("Horizontal distance (m)")
