I am a primitive decorator in charge of initialize new objects created with the basicNew primitive. The VM will create them referencing the local nil instance. We will replace those references by the correct nil object (both variable and fixed fields).

Bit fields will stay as they are