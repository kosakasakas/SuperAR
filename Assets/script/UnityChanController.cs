using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Animator))]
public class UnityChanController : MonoBehaviour {
	
	private Animator animator;
	private int doWalkId;
	
	// Use this for initialization
	void Start () {
		animator = GetComponent<Animator> ();
		doWalkId = Animator.StringToHash ("doWalk");
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetKey(KeyCode.UpArrow)) {
			animator.SetBool(doWalkId, true);
		}else{
			animator.SetBool(doWalkId, false);
		}
	}
}