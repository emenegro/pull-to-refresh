/*
 * Copyright (c) 06/11/2012 Mario Negro
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
 * KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

/**
 * Enumerates control's state
 */
typedef enum {
    
    MNMPullToRefreshViewStateIdle = 0, //<! The control is invisible right after being created or after a reloading was completed
    MNMPullToRefreshViewStatePull, //<! The control is becoming visible and shows "pull to refresh" message
    MNMPullToRefreshViewStateRelease, //<! The control is whole visible and shows "release to load" message
    MNMPullToRefreshViewStateLoading //<! The control is loading and shows activity indicator

} MNMPullToRefreshViewState;

/**
 * Pull to refresh view. Its state, visuals and behavior is managed by an instance of MNMPullToRefreshManager
 */
@interface MNMPullToRefreshView : UIView 

/**
 * Returns YES if activity indicator is animating
 */
@property (nonatomic, readonly) BOOL isLoading;

/**
 * Last update date
 */
@property (nonatomic, readwrite, strong) NSDate *lastUpdateDate;

/**
 * Fixed height of the view
 */
@property (nonatomic, readonly) CGFloat fixedHeight;

/**
 * Changes the state of the control depending in state and offset values
 *
 * @param state The state to set
 * @param offset The offset of the table scroll
 */
- (void)changeStateOfControl:(MNMPullToRefreshViewState)state withOffset:(CGFloat)offset;

@end
