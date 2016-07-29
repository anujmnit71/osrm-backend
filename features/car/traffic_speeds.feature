@routing @speed @traffic
Feature: Traffic - speeds

    Background: Use specific speeds
        Given the node locations
            | node | lat        | lon      |
            | a    | 0.1        | 0.1      |
            | b    | .05        | 0.1      |
            | c    | 0.0        | 0.1      |
            | d    | .05        | .03      |
            | e    | .05        | .066     |
            | f    | .075       | .066     |
            | g    | .075       | 0.1      |
        And the ways
            | nodes | highway |
            | ab    | primary |
            | ad    | primary |
            | bc    | primary |
            | dc    | primary |
            | de    | primary |
            | eb    | primary |
            | df    | primary |
            | fb    | primary |
        And the speed file
        """
        1,2,0
        2,1,0
        2,3,27
        3,2,27
        1,4,27
        4,1,27
        """

    Scenario: Weighting based on speed file
        Given the profile "testbot"
        Given the extract extra arguments "--generate-edge-lookup"
        Given the contract extra arguments "--segment-speed-file speeds.csv"
        And I route I should get
            | from | to | route          | speed   |
            | a    | b  | ad,de,eb,eb    | 30 km/h |
            | a    | c  | ad,dc,dc       | 31 km/h |
            | b    | c  | bc,bc          | 27 km/h |
            | a    | d  | ad,ad          | 27 km/h |
            | d    | c  | dc,dc          | 36 km/h |
            | g    | b  | fb,fb          | 36 km/h |
            | a    | g  | ad,df,fb,fb    | 30 km/h |

