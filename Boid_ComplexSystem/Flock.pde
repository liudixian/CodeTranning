class Flock
{
    ArrayList<Boid> boides;
      
    Flock(){
        boides = new ArrayList<Boid>();
    }

    void run(){
        for(Boid b: boides){
            b.run(boides);
        }
    }

    void add(Boid b){
        boides.add(b);
    }
}
