Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

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
    Debug.Notification("Zombie already tracked. Exiting.")
    Return
  EndIf

  Debug.Notification("Searching for alias for Zombie.")

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
      Else
        Debug.Notification("Alias already in use.")
      EndIf
    EndIf

    If Zombie == None
      AliasFound = True
      NEP_ZombieFormList.AddForm(Target)
      ZombieAlias.ForceRefTo(Target as ObjectReference)
      Debug.Notification("Zombie tracked.")
    EndIf
  EndWhile

  If !AliasFound
    Debug.Notification("No alias found for Zombie.")
  EndIf

EndFunction
