logo = "your_logo.png"; //set your logo file name
logo_x = 420; // width of the logo image in pixels
logo_y = 74; // height of the logo image in pixels

tolerance = 0.2;
left_keychain_hole_size = 5; // left hole size in mm for the keychain ring
right_keychain_hole_size = 0; // right hole size in mm for the keychain ring
size_x = 70; // width of the keychain tag in mm
size_y = 23; // height of the keychain tag in mm
size_z = 3; // thickness of the keychain tag in mm
x_gap = 3; // mm between the logo and the left/right border
y_gap = 3; // mm between the logo and the top/bottom border

function GetLeftGap() = left_keychain_hole_size > 0 ? left_keychain_hole_size + x_gap * 2 : x_gap;
function GetRightGap() = right_keychain_hole_size > 0 ? right_keychain_hole_size + x_gap * 2 : x_gap;

cube_size_x = size_x - size_y;
left_gap = GetLeftGap();
right_gap = GetRightGap();
image_size_x = size_x - left_gap - right_gap;
scale_factor = image_size_x / logo_x;
image_size_y = scale_factor * logo_y;

difference()
{
    union()
    {
        cube([cube_size_x, size_y, size_z]);
        translate([0, size_y / 2, 0]) 
            cylinder(h = size_z, r = size_y / 2);
        translate([cube_size_x, size_y / 2, 0]) 
            cylinder(h = size_z, r = size_y / 2);
    }
    translate([left_gap - size_y / 2, image_size_y - y_gap, size_z]) 
        scale([scale_factor, scale_factor, size_z / 100]) 
        surface(file = logo, invert = true); 
    if (left_keychain_hole_size > 0)
    {
        translate([0 - size_y / 2 + 3 + left_keychain_hole_size / 2, size_y / 2, 0])
            cylinder(h = size_z, r = (left_keychain_hole_size + tolerance) / 2);
    }
    if (right_keychain_hole_size > 0)
    {
        translate([cube_size_x + size_y / 2 - 3 - right_keychain_hole_size / 2, size_y / 2, 0]) 
            cylinder(h = size_z, r = (right_keychain_hole_size + tolerance) / 2);
    }
}
