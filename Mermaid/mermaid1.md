```mermaid
  graph RL
   
    subgraph "Business"
        BF("Business Function")
    end
    What(("What"))
    
    Business <-->|   | What 
    
    
    subgraph "Motivation"
        Goal("Goal")
        Requirement("Requirement")
    end
    WHY(("WHY"))
    
    Motivation <-->|   | WHY 

    
  

