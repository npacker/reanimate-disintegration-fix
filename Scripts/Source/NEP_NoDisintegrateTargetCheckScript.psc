Scriptname NEP_NoDisintegrateTargetCheckScript extends ActiveMagicEffect
{Script attached to Dead Thrall target check effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFixQuest Auto
{Reanimate Fix Quext script.}

Faction Property NEP_ReanimateFixNoDisintegrateFaction Auto
{Faction for all zombies that should not disintegrate on death.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Target.AddToFaction(NEP_ReanimateFixNoDisintegrateFaction)
  NEP_ReanimateFixQuest.TrackZombie(Target)
  Self.Dispel()

EndEvent
