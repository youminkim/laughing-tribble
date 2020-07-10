use <BezierScad/BezierScad.scad>;

$fn=20;

width = 1;
height = 1;
steps = 100;
centered = true;

cylinder_r = 1.1;
cylinder_h = 1.0;

bolt_h = 1.7;
bolt_r = 0.65;
bolt_translate_z= 0.9;

hole_h = 1.2;
hole_r = 0.75;

module leaf(pts, loc, has_bolt=true) {
    difference(){
        union(){
            translate(loc) 
                BezWall(pts, width, height, steps, centered);
            translate(pts[len(pts)-1])
                cylinder(h=cylinder_h, r=cylinder_r);
        }
        if (!has_bolt){
            translate(pts[len(pts)-1])
                translate([0,0,-0.1]) // safe margin
                    cylinder(h=hole_h, r=hole_r);
        }
    }
    
    // bolt
    if(has_bolt){
        bolt_connect(pts[len(pts)-1]);       
    }
    
}

module leafs(loc) {
    leaf (
        [[0,0], [-5,10], [10, 20], [5,40]], 
        loc,
        true
    );

    leaf (
        [[0,0], [-4,20], [10,5], [15,15]], 
        loc,
        false
    );

    leaf (
        [[0,0], [-5,10], [-2, 5], [-5,20]],
        loc,
        true
    );
}

module bolt_connect(loc) {
    // bolt
    translate(loc)
        translate([0, 0, bolt_translate_z])
            cylinder(h=bolt_h, r=bolt_r);
}

difference(){
    union(){
        leafs([0,0,0]);
        translate([0,0,0])
            cylinder(h=cylinder_h, r=cylinder_r);
    }
    translate([0,0,-0.1])
        cylinder(h=hole_h, r=hole_r);
}


