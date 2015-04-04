using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

[RequireComponent(typeof (CustomThirdPersonCharacter))]
public class CustomThirdPersonUserControl : ThirdPersonUserControl {

	// Use this for initialization
	void Start () {
		base.Start ();
		character = GetComponent<CustomThirdPersonCharacter>();
	}
	
	// Update is called once per frame
	void Update () {
		base.Update ();

		if (Input.GetKey (KeyCode.Return)) {
			((CustomThirdPersonCharacter)character).MegaBeam();
		}
	}
}
