Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{The player.}

Perk Property NEP_ReanimateFixPerk Auto
{Perk that applies entry point for reanimate effect fix.}

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

FormList Property NEP_ZombieFormList Auto
{Form list of tracked Zombies.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TrackZombie(Actor Target)

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  If NEP_ZombieFormList.HasForm(Target)
    Return
  EndIf

  While Index && !AliasFound
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie == None
      AliasFound = True
      NEP_ZombieFormList.AddForm(Target)
      ZombieAlias.ForceRefTo(Target as ObjectReference)
    EndIf
  EndWhile

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  If !PlayerRef.HasPerk(NEP_ReanimateFixPerk)
    PlayerRef.AddPerk(NEP_ReanimateFixPerk)
  EndIf

EndEvent
