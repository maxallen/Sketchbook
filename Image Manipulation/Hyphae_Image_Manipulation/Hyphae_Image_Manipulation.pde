/* ---------------------------------------- */
// Max Allen
//
// Image manipulation using Perlin Noise Particles
// ---------------------------------------------- //
// STRATEGY 1:
// ** Picture is loaded in a B&W buffer
// ** Many Particles are created
// ** Velocity of particle is determined by brightness in corresponding pixel in picture 
// **** Brighter pixels have a slower velocity and a higher angular turn rate (to stay in same area)
// **** Darker pixels have high velocity and low angular momentum to push the particle out of that region
// ----------------------------------------------------------------------------------------------------- //
// STRATEGY 2:
// ** Picture is loaded in a B&W buffer
// ** Few Particles are created
// ** Particles move in a perlin noise pseudo-random manner.
// ** Each particle adds the brightness of the current pixel in the corresponding BW image to its counter
// ** Every time the counter hits a certain number, the particle doubles and creates a new particle 
// ** There needs to be a kill method of the particle either dependent on the number of children its made or how far it has moved
// ----------------------------------------------------------------------------------------------------------------------------- //
// STRATEGY 3:
// ** Picture is loaded in a B&W buffer
// ** Many Particles are created
// ** The color of the particle is correlated to the brightness to the pixel in the image

/* ---------------------------------------- */




void setup() {
  
}

void draw() {
  
}

class Particle {
  
  PVector location;
  PVector velocity;
  int currApp;
  int fullApp;
  
  Particle () {
    
  }
  
}
