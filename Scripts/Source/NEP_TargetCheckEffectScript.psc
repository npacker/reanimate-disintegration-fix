Scriptname NEP_TargetCheckEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimate fix tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFixQuest Auto
{Reanimate Fix Quext script.}

Faction Property SpellFaction = None Auto
{Optional faction to apply to the target.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  If SpellFaction
    Target.AddToFaction(SpellFaction)
  EndIf

  NEP_ReanimateFixQuest.TrackZombie(Target)
  Self.Dispel()

EndEvent
