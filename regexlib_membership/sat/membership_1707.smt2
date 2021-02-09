;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[^&gt;]+&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;\x19~&gt;~"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "\x19" (seq.++ "~" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "~" ""))))))))))))
;witness2: "\u00CB&lt;\u009A&gt;r1"
(define-fun Witness2 () String (seq.++ "\xcb" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "\x9a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "r" (seq.++ "1" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.+ (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff")))))) (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
