;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;!\[CDATA\[([^\]]*)\]\]&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;![CDATA[]]&gt;9\u00E5"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "!" (seq.++ "[" (seq.++ "C" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "A" (seq.++ "[" (seq.++ "]" (seq.++ "]" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "9" (seq.++ "\xe5" "")))))))))))))))))))))
;witness2: "&lt;![CDATA[\u00D5]]&gt;\u00D0"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "!" (seq.++ "[" (seq.++ "C" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "A" (seq.++ "[" (seq.++ "\xd5" (seq.++ "]" (seq.++ "]" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "\xd0" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "!" (seq.++ "[" (seq.++ "C" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "A" (seq.++ "[" "")))))))))))))(re.++ (re.* (re.union (re.range "\x00" "\x5c") (re.range "^" "\xff"))) (str.to_re (seq.++ "]" (seq.++ "]" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
