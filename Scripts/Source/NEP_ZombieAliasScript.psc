Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFixQuest Auto
{Reanimate Fix Quext script.}

Actor Property PlayerRef Auto
{The player.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fOffsetDistance = 100.0

Float fDelay = 4.0

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function CheckZombie()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie != None
    If Zombie.IsDisabled() || Zombie.IsDeleted()
      Zombie.Kill()
    EndIf

    UnregisterForUpdate()
    RegisterForSingleUpdate(fDelay)
  EndIf

EndFunction

Function MoveZombieToPlayer(Actor Zombie)

  Cell ZombieCell = Zombie.GetParentCell()
  Cell PlayerCell = PlayerRef.GetParentCell()

  If ZombieCell != PlayerCell
    If ZombieCell && ZombieCell.IsInterior() \
        || PlayerCell && PlayerCell.IsInterior()
      float XOffset = Math.Sin(PlayerRef.GetAngleZ()) * fOffsetDistance
      float YOffset = Math.Cos(PlayerRef.GetAngleZ()) * fOffsetDistance
      float ZOffset = 0.0

      Zombie.MoveTo(PlayerRef, XOffset, YOffset, ZOffset, True)
    EndIf
  EndIf

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUnload()

  CheckZombie()

EndEvent

Event OnCellDetach()

  CheckZombie()

EndEvent

Event OnDetachedFromCell()

  CheckZombie()

EndEvent

Event OnUpdate()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie != None
    If Zombie.IsDead()
      NEP_ReanimateFixQuest.CleanUpZombie(Self, Zombie)
    Else
      MoveZombieToPlayer(Zombie)
    EndIf
  EndIf

EndEvent

Event OnDeath(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  If Zombie != None
    NEP_ReanimateFixQuest.CleanUpZombie(Self, Zombie)
  EndIf

EndEvent
