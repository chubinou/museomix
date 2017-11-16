Ce code correspond au projet "CurieOzity Bus" de l'equipe CurieOz pendant le hackathon 
museomix 2017. 

Le principe est que, les participant, après une serie de questions, viennent poser 3 pieces d'une 
cléf sur un tableau de bord, Si les trois cléfs sont correctes, le bus va demmarer, sinon une video 
d'erreur va se lancer.
     --play-and-pause \

Lorsque le bus se demmare:

  - une vidéo se lance (decolage de la terre, direction mars)
  
  - l'un des sieges des participant va se mettre à vibrer au decolage et à l'atterissage sur mars.
  
  - des animations d'atmosphere sont diffusées sur un écran special.
  

Le systeme se compose:
  
  - d'un arduino, il sert a :
  
    - effectuer les mesures pour la cléf (mesures sur pont diviseur de tension, chaque piece ayant 
      une resistance caracteristique). les mesures sont transmises via liaison serie vers le pc de
      controle
      
    - déclancher les vibrations d'un siege en alimantant un moteur desaxé. les commandes de vibrations
      sont recues par liason serie.

  - d'un pc sous linux, il va:
    
    - permettre de lancer des sequences vidéos via VLC
    
    - déclancher des animations d'atmosphere, ces animations sont controlées par un programme externe 
      non disponible sur ce depot. Les demandes de changements d'etat sont effectuée en evoyant des 
      messages sur websockets
    
    - dialoguer avec l'arduino pour lire les mesures et declancher les vibrations
    

VLC sert de serveur video, il doit etre lancé avec les options suivantes:

.. code:: sh

    vlc \
     --fullscreen \
     --no-video-title-show \
     --extraintf lua \
     --lua-intf web \
     --http-port 5921 \
     --http-password xxx \
     --play-and-pause
