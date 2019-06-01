#define test_suite_end
if (global.testnumber == global.testssucceeded) {
   show_message(string(global.testssucceeded) + "/" + string(global.testnumber) + " tests OK!");
} else {
   show_message(string(global.testssucceeded) + "/" + string(global.testnumber) + " tests OK! (FAILED TESTS)");
}

#define test_suite_init
global.testnumber = 0;
global.testssucceeded = 0;

#define test_assert_same
//Run a unit test (has nothing to do with scripts. Just testing of the scripts).
expected = argument0;
given = argument1;
global.testnumber++;

show_debug_message("Testing #" + string(global.testnumber));

if (expected == given) {
   show_debug_message("OK");
   global.testssucceeded++;
} else {
  global.testsuccess = false;
  show_debug_message("             FAIL!");
  show_debug_message("Expected (+) Given (=)");
  show_debug_message("+" + string(expected));
  show_debug_message("=" + string(given));
}

#define dectohex
/**
 * Turn decimal into heximal
 * @param integer argument0 The decimal to convert
 * @return string
 */
var n,r;
n=argument0;
r="";
while(n) {
    r=string_char_at("0123456789ABCDEF",n mod 16+1)+r;
    n=n div 16
}
if (r == "") {
   r = '0';
}
return r;

#define hextodec
/**
 * Convert hexadecimal string to decimal number
 * @param string argument0 The string to convert
 * @return integer
 */
var d,r,l;
r=0;
d=string_upper(argument0);
l=string_length(d);
if(l>6) return -1;
for (i=l;i>0;i-=1) {
    r+=(string_pos(string_char_at(d,i),"0123456789ABCDEF")-1) * power(16,l-i);
}
return r;

#define string_explode
/**
 * Explode a string based on a key
 * @param string argument0 Seperator - Explode on what character(s)
 * @param string argument1 String to explode
 * @return array|null (Returns null if no seperator was found)
 */
var array, seperator, data;

seperator = argument0;
data = argument1;

//Check if the seperator was found in the string.
if (!string_count(seperator,data)) {
   array[0] = data;
} else {
    length = string_length(seperator);
    i = 0;
    repeat (string_count(seperator,data)) {
        p = string_pos(seperator,data)-1;
        array[i] = string_copy(data,1,p);
        data = string_delete(data,1,p+length);
        i += 1;
    }
}
return array;

#define array_implode
/**
 * Implode an array based on a key
 * @param string argument0 Seperator - Implode using what character
 * @param array argument1 Array to implode
 * @return string
 *
 * Please note that GM does not support missing array indexes. Check out the test (Number 9)
 */
var output, seperator, data;
seperator = argument0;
array = argument1;

output = "";
for (i=0; i<array_length_1d(array); i++) {
    output = output + string(array[i]) + string(seperator);
}
length = string_length(seperator);
output = string_copy(output,0, string_length(output) - string_length(seperator));
return output;

#define string_reverse
/**
 * Reverse a string
 * @param string argument0 String to reverse
 * @return string
 */
output = "";

length = string_length(argument0);
for (i=0; i<length; i++) {
    output += string_char_at(argument0, length-i);
}
return output;

#define string_mask
/**
 * Hide a string based on its length
 * @param string argument0 Character to use (e.g. "*" or "•")
 * @param string argument1 The string to mask
 * @return string
 */
return string_repeat(argument0, string_length(argument1));

#define url_encode
/**
 * Encode a string based on RFC 1738 
 * @param string argument0 The string to encode
 * @return string
 */
 //@todo - doesn't work over ord(255) (hex FF) characters...
 
output = "";
for (i = 1; i <= string_length(argument0); i += 1) {
     char = string_char_at(argument0, i);
     if (string_pos(char, ' {}[]|\^`"#%<>;/@$=:?&') > 0 || ord(char) > 126 && ord(char) < 255) {
         char = '%' + dectohex(ord(char));
     }
     output += char;
}
return output;

#define url_decode
/**
 * Decode a string based on RFC 1738 
 * @param string argument0 The string to decode
 * @return string
 */
 //@todo only works up to #FF (255) characters.
dec = argument0;
output = "";
pos = string_pos('%', dec);
while (pos != 0) {
    //Copy general output
    output += string_copy(dec, 1, pos-1);
    //Grab part to decode
    str = string_copy(dec, pos+1, 2);
    //Decode and add to output
    output += chr(hextodec(str));
    //Remove all up to this thing
    dec = string_delete(dec, 1, pos+2);
    //Reset pointer
    pos = string_pos('%', dec);
}
return output + dec;

#define string_ends_with
/**
 * Check if string ends with string
 * @param string argument0 haystack
 * @param string argument1 needle
 * @return boolean
 */
sl0 = string_length(argument0);
sl1 = string_length(argument1);

if (sl0+sl1 == 0) { return true; }
if (argument0 == argument1) { return true; }
if (sl1 == 0) { return true; }
if (sl0 == 0) { return false; }
if (sl1 > sl0) { return false; } //Quite sure.

return (string_copy(argument0, sl0-sl1+1, sl1) == argument1);

#define string_starts_with
/**
 * Check if string starts with string
 * @param string argument0 haystack
 * @param string argument1 needle
 * @return boolean
 */
sl0 = string_length(argument0);
sl1 = string_length(argument1);
if (sl0+sl1 == 0) { return true; }
if (argument0 == argument1) { return true; }
if (sl0 == 0) { return false; }
if (sl1 == 0) { return true; }
if (sl1 > sl0) { return false; } 

return (string_copy(argument0, 1, sl1) == argument1);

