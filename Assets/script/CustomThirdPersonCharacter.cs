using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

public class CustomThirdPersonCharacter : ThirdPersonCharacter {

	private bool beam;

	// Use this for initialization
	void Start () {
		base.Start ();
	}

	public void MegaBeamStart() {
		beam = true;
	}

	public void MegaBeamStop() {
		beam = false;
	}

	protected override void UpdateAnimator()
	{
		base.UpdateAnimator ();
		
		animator.SetBool("Beam", beam);

		Debug.Log (beam);
	}
}
