Scriptname RDF_EntryPointEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimate fix tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

RDF_AliasController Property Controller Auto
{Reanimate Disintegration Fix alias controller script.}

Faction Property SpellFaction = None Auto
{Optional faction to apply to the target.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor Zombie

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Zombie = Target

  Debug.TraceAndBox("Entry Point Effect Start: " + Zombie)

  If SpellFaction
    Zombie.AddToFaction(SpellFaction)
  EndIf

  Bool Done = Controller.TrackZombie(Zombie)

  If !Done
    RegisterForModEvent("RDF_AliasControllerReady", "AliasControllerReady")
  Else
    Self.Dispel()
  EndIf

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Debug.TraceAndBox("Entry Point Effect End: " + Zombie)

EndEvent

Event AliasControllerReady(String EventName, String CallbackName)

  UnregisterForModEvent("RDF_AliasControllerReady")

  Bool Done = Controller.TrackZombie(Zombie)

  If !Done
    RegisterForModEvent("RDF_AliasControllerReady", "AliasControllerReady")
  Else
    Self.Dispel()
  EndIf

EndEvent
