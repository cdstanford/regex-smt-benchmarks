;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[^&gt;]+&gt;
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;\x19~&gt;~"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{19}" (str.++ "~" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "~" ""))))))))))))
;witness2: "\u00CB&lt;\u009A&gt;r1"
(define-fun Witness2 () String (str.++ "\u{cb}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{9a}" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "r" (str.++ "1" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.+ (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}")))))) (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
