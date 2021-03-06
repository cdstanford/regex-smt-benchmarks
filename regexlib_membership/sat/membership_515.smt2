;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = style="[^"]*"|'[^']*'
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "style=\"\x12\u00E3\u00F18\u0082\"D"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x12" (seq.++ "\xe3" (seq.++ "\xf1" (seq.++ "8" (seq.++ "\x82" (seq.++ "\x22" (seq.++ "D" "")))))))))))))))
;witness2: "\'\'"
(define-fun Witness2 () String (seq.++ "'" (seq.++ "'" "")))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "s" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "=" (seq.++ "\x22" ""))))))))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
