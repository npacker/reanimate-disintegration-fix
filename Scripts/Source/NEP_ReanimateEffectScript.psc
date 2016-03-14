Scriptname NEP_ReanimateEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimated thrall tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  While Index && !AliasFound
    Index -= 1
    AliasFound = ZombieAliases[Index].ForceRefIfEmpty(Target as ObjectReference)
  EndWhile

EndEvent
