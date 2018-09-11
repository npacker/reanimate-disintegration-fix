Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFix Auto
{Reanimate Fix Quext script.}

Actor Property PlayerRef Auto
{The player.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fOffsetDistance = 100.0

Float fUpdateDelay = 1.0

Float fOnDyingDelay = 0.5

Float fWait = 0.01

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function CheckZombie()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie
    If Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted() \
        || !Zombie.IsCommandedActor()
      UntrackZombie(Zombie)
    Else
      MoveZombieToPlayer(Zombie)
    EndIf
  EndIf

EndFunction

State Moving

  Function MoveZombieToPlayer(Actor Zombie)
  EndFunction

EndState

Function MoveZombieToPlayer(Actor Zombie)

  GoToState("Moving")

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

  GoToState("")

EndFunction

State Dying

  Function UntrackZombie(Actor Zombie)
  EndFunction

  Event OnUpdate()
  EndEvent

  Event OnDying(Actor Killer)
  EndEvent

  Event OnDeath(Actor Killer)
  EndEvent

EndState

Function UntrackZombie(Actor Zombie)

  GoToState("Dying")

  Bool Done = NEP_ReanimateFix.UntrackZombie(Self, Zombie)

  While !Done
    Utility.Wait(fWait)
    Done = NEP_ReanimateFix.UntrackZombie(Self, Zombie)
  EndWhile

  GoToState("")

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUnload()

  RegisterForSingleUpdate(fUpdateDelay)

EndEvent

Event OnCellDetach()

  RegisterForSingleUpdate(fUpdateDelay)

EndEvent

Event OnUpdate()

  CheckZombie()

EndEvent

Event OnDying(Actor Killer)

  RegisterForSingleUpdate(fOnDyingDelay)

EndEvent

Event OnDeath(Actor Killer)

  RegisterForSingleUpdate(fWait)

EndEvent
