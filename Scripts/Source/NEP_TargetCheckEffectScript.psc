Scriptname NEP_TargetCheckEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimate fix tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFixQuest Auto
{Reanimate Fix Quext script.}

Faction Property NEP_ReanimateFixDeadThrallFaction Auto
{Faction to store dead thrall zombies.}

Keyword Property RitualSpellEffect Auto
{Ritual Spell Effect (present if zombie is Dead Thrall.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  NEP_ReanimateFixQuest.TrackZombie(Target)

  If Target.HasMagicEffectWithKeyword(RitualSpellEffect)
    Target.AddToFaction(NEP_ReanimateFixDeadThrallFaction)
  EndIf

EndEvent

