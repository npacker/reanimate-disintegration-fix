Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{The player.}

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

Perk Property NEP_ReanimateFixPerk Auto
{Reanimate Fix perk, provides entry point to all reanimate spells.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TrackZombie(Actor Target)

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  If ZombieAlreadyTracked(Target)
    Return
  EndIf

  While Index && !AliasFound
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      If Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted()
        Zombie.DispelAllSpells()
        Zombie.Kill()
        ZombieAlias.Clear()

        Zombie = None
      EndIf
    EndIf

    If Zombie == None
      AliasFound = True
      ZombieAlias.ForceRefTo(Target as ObjectReference)
    EndIf
  EndWhile

EndFunction

Bool Function ZombieAlreadyTracked(Actor Target)

  Bool Result = False
  Int Index = ZombieAliases.Length

  While Index && !Result
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie == Target
      Result = True
    EndIf
  EndWhile

  Return Result

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  PlayerRef.AddPerk(NEP_ReanimateFixPerk)

EndEvent
