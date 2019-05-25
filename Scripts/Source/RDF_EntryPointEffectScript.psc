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

Float fWait = 0.01

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Debug.TraceAndBox("Entry Point Effect Start: " + Target)

  If SpellFaction
    Target.AddToFaction(SpellFaction)
  EndIf

  Bool Done = Controller.TrackZombie(Target)

  While !Done
    Utility.Wait(fWait)
    Done = Controller.TrackZombie(Target)
  EndWhile

  Debug.TraceAndBox("Entry Point Effect End: " + Target)

  Self.Dispel()

EndEvent
