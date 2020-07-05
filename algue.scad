use <BezierScad/BezierScad.scad>;

$fn=20;

width = 1;
height = 1;
steps = 100;
centered = true;

cylinder_r = 1.1;
cylinder_h = 1.0;

volt_h = 1.0;
volt_r = 0.7;
volt_translate_z= 0.9;

hole_h = 1;
hole_r = 0.75;

module leaf(pts, loc) {
    difference(){
        union(){
            translate(loc) 
                BezWall(pts, width, height, steps, centered);
            translate(pts[len(pts)-1])
                cylinder(h=cylinder_h, r=cylinder_r);
        }

        translate(pts[len(pts)-1])
            scale([1, 1, 1.01]) // safe margin
                cylinder(h=hole_h, r=hole_r);
    }

    // volt
    volt_connect(pts[len(pts)-1]);       
}

module leafs(loc) {
    leaf (
        [[0,0], [-5,10], [10, 20], [5,40]], 
        loc
    );

    leaf (
        [[0,0], [-4,20], [10,5], [15,15]], 
        loc
    );

    leaf (
        [[0,0], [-5,10], [-2, 5], [-5,20]],
        loc
    );
}

module volt_connect(loc) {
    // volt
    translate(loc)
        translate([0, 0, volt_translate_z])
            cylinder(h=volt_h, r=volt_r);

    // volt base
    translate(loc)
        translate([0, 0, volt_translate_z])
            cylinder(h=cylinder_h*0.01, r=cylinder_r);
}

difference(){
    union(){
        leafs([0,0,0]);
        translate([0,0,0])
            cylinder(h=cylinder_h, r=cylinder_r);
    }
    scale([1,1,1.01])
        cylinder(h=hole_h, r=hole_r);
}
volt_connect([0,0,0]);


