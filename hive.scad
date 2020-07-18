width = 260;
height = 630;
thickness = 4;

num_circles = 16;
num_circles_z = height/(width/num_circles);
circle_r = 6;

cup_height = 25;

facades();

difference(){
    cube([width, width, cup_height]);
    translate([thickness, thickness, thickness])
        cube([width-thickness*2, width-thickness*2, cup_height]);
}

module facades(){
    facade();
    
    rotate([0, 0, 90])
        facade(); 

    translate([width, width, 0])
        rotate([0, 0, 180])
            facade(); 

    translate([width-thickness, width, 0])
        rotate([0, 0, 270])
            facade(); 
}

module facade(){
        difference(){
            cube([width, thickness, height], center=false);
            facade_hole();
        }
}

module facade_hole(){
    for (i = [0:num_circles]){
        for (j = [0:num_circles_z]){
            shift = (j%2) * (width/num_circles)/2;
                translate([shift+i*width/num_circles, thickness/2, j*height/num_circles_z])
                    rotate([90, 0, 0])
                        cylinder(h = thickness*1.01, r=circle_r, center=true);
        }
    }
}

