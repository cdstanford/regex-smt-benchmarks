;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;!\[CDATA\[([^\]]*)\]\]&gt;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;![CDATA[]]&gt;9\u00E5"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "!" (str.++ "[" (str.++ "C" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "A" (str.++ "[" (str.++ "]" (str.++ "]" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "9" (str.++ "\u{e5}" "")))))))))))))))))))))
;witness2: "&lt;![CDATA[\u00D5]]&gt;\u00D0"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "!" (str.++ "[" (str.++ "C" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "A" (str.++ "[" (str.++ "\u{d5}" (str.++ "]" (str.++ "]" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "\u{d0}" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "!" (str.++ "[" (str.++ "C" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "A" (str.++ "[" "")))))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{5c}") (re.range "^" "\u{ff}"))) (str.to_re (str.++ "]" (str.++ "]" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
