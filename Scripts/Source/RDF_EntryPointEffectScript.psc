Scriptname RDF_EntryPointEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimate fix tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

RDF_AliasController Property Controller Auto
{Reanimate Disintegration Fix alias controller script.}

Faction[] Property ZombieFactions Auto
{Optional factions to add the target to, for determining their zombie effects.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor Zombie

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TrackZombie()

  Bool Done = Controller.TrackZombie(Zombie)

  If !Done
    RegisterForModEvent("RDF_AliasControllerReady", "AliasControllerReady")
  Else
    Self.Dispel()
  EndIf

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Zombie = Target

  Debug.TraceAndBox("Entry Point Effect Start: " + Zombie)

  Int i = ZombieFactions.Length

  While i
    i -= 1
    Zombie.AddToFaction(ZombieFactions[i])
  EndWhile

  TrackZombie()

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Debug.TraceAndBox("Entry Point Effect End: " + Zombie)

EndEvent

Event AliasControllerReady(String EventName, String CallbackName)

  UnregisterForModEvent("RDF_AliasControllerReady")
  TrackZombie()

EndEvent
