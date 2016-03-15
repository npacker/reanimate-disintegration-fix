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

  Debug.Trace("NEP_ReanimateEffectScript: OnEffectStart")

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  While Index && !AliasFound
    Index -= 1
    AliasFound = ZombieAliases[Index].ForceRefIfEmpty(Target as ObjectReference)
  EndWhile

  Debug.Trace("NEP_ReanimateEffectScript: Zombie alias found " + AliasFound)

  If AliasFound
    Debug.Trace("NEP_ReanimateEffectScript: Zombie " + Target + " added to " + ZombieAliases[Index] + " alias")
  EndIf

EndEvent
