using UnityEngine;
using System.Collections;

public class ClippingController : MonoBehaviour {

	public GameObject farClipTarget = null;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (farClipTarget == null) {
			return;
		}

		float distance = Vector3.Distance (Camera.main.transform.position, farClipTarget.transform.position);
		Camera.main.farClipPlane = distance + 0.01f;
	}
	
}
