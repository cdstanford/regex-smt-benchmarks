;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[aA][ ]{0,}([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,}&gt;((&lt;(([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,})&gt;([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,})|(([a-zA-Z0-9&quot;'_,.:;!?@$&amp;()%=/ ]|[-]|[	\f]){0,})){0,}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;A &gt;\x9\u00DA"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "A" (seq.++ " " (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "\x09" (seq.++ "\xda" "")))))))))))))
;witness2: "\x4\u0084&lt;a&gt;\x9r&lt;\xCQ&gt;"
(define-fun Witness2 () String (seq.++ "\x04" (seq.++ "\x84" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "\x09" (seq.++ "r" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "\x0c" (seq.++ "Q" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.union (re.range "\x09" "\x09")(re.union (re.range "\x0c" "\x0c")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))) (re.* (re.union (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.* (re.union (re.range "\x09" "\x09")(re.union (re.range "\x0c" "\x0c")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))) (re.* (re.union (re.range "\x09" "\x09")(re.union (re.range "\x0c" "\x0c")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))) (re.* (re.union (re.range "\x09" "\x09")(re.union (re.range "\x0c" "\x0c")(re.union (re.range " " "!")(re.union (re.range "$" ")")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
