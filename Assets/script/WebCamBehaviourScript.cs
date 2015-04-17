using UnityEngine;
using System.Collections;

public class WebCamBehaviourScript : MonoBehaviour
{
	public int Width = 1920;
	public int Height = 1080;
	public int FPS = 30;
	public bool Mirror = false;
	
	// Use this for initialization
	void Start()
	{
		var devices = WebCamTexture.devices;
		if ( devices.Length == 0 ) {
			Debug.LogError( "Webカメラが検出できませんでした。" );
			return;
		}

		if ( Mirror ) {
			transform.localScale = new Vector3( -transform.localScale.x,
			                                   transform.localScale.y,
			                                   transform.localScale.z );
		}

		// WebCamテクスチャを作成する
		var webcamTexture = new WebCamTexture( Width, Height, FPS );
		GetComponent<Renderer>().material.mainTexture = webcamTexture;
		webcamTexture.Play();
	}
	
	// Update is called once per frame
	void Update()
	{

	}
}