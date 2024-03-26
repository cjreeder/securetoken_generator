# SecureToken Generator 

This script is used to generated securetoken hashes. If you want to generate hashes for Wowza's SecureToken, you code needs to be configured properly. 

First, you need to know the Application Instance, the stream name, the SecureToken Shared Secret in the application instance, and Hash Query Parameter Prefix also in that application instance. 

These are all setup on the Application Instance in Wowza.  Here is an example configuration:
Application Instance: live-app
Stream Name: stream01
SecureToken Shared Secret: mysecuresharedsecret
Hash Query Parameter Prefix: zhashinstance

According to the documentation found on Wowza's website, the query you are creating needs to be in alphabeticall order.  That is I put the z in the front of the hash query parameter prefix so it doesn't reorder things.
1. Build your query with the following parameters in alphabetical order
- (This token is split up by the following “Name of Application + / + name of stream + ? + SecureToken Shared Secret + &zhashinstanceendtime= + end time in Epoch UnixTime + &tokenstarttime= + start time in Epoch UnixTime)
- ie "live-app/stream01?mysecuresharedsecret&zhashinstanceendtime=1706312333&zhashinstancestarttime=1706333933" 

2. Run the script with this as the value passed to the script
- ie ./securetoken.sh "live-app/stream01?mysecuresharedsecret&zhashinstanceendtime=1706312333&zhashinstancestarttime=1706333933"

3. the output should be a nice hash that you can then use to access the video using url with the securetoken hash at the end
- ie u4OoUQUj2IFz18aKsf0Gn0DGoadV7WhtWlZkypXCXfc=

4. To use this instance in vlc or some other streaming system, you can take the url and plug it in
- ie https://my-secure-wowza-server-address/live-app/stream01/playlist.m3u8?zhashinstancestarttime=1706333933&zhashinstanceendtime=1706312333&zhashinstancehash=u4OoUQUj2IFz18aKsf0Gn0DGoadV7WhtWlZkypXCXfc=
