;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[aA][ ]{0,}([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,}&gt;((&lt;(([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,})&gt;([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,})|(([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,})){0,}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;A &gt;\x9\u00DA"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "A" (str.++ " " (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "\u{09}" (str.++ "\u{da}" "")))))))))))))
;witness2: "\x4\u0084&lt;a&gt;\x9r&lt;\xCQ&gt;"
(define-fun Witness2 () String (str.++ "\u{04}" (str.++ "\u{84}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "\u{09}" (str.++ "r" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{0c}" (str.++ "Q" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.union (re.range "\u{09}" "\u{09}")(re.union (re.range "\u{0c}" "\u{0c}")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))) (re.* (re.union (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{09}")(re.union (re.range "\u{0c}" "\u{0c}")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))) (re.* (re.union (re.range "\u{09}" "\u{09}")(re.union (re.range "\u{0c}" "\u{0c}")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))) (re.* (re.union (re.range "\u{09}" "\u{09}")(re.union (re.range "\u{0c}" "\u{0c}")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
