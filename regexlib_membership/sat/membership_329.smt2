;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((s*)(ftp)(s*)|(http)(s*)|mailto|news|file|webcal):(\S*))|((www.)(\S*))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "www\x1Fq\u00CC\u00A6\u00B4"
(define-fun Witness1 () String (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "\x1f" (seq.++ "q" (seq.++ "\xcc" (seq.++ "\xa6" (seq.++ "\xb4" "")))))))))
;witness2: "www\x1ED\u00A6"
(define-fun Witness2 () String (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "\x1e" (seq.++ "D" (seq.++ "\xa6" "")))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.* (re.range "s" "s"))(re.++ (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))) (re.* (re.range "s" "s"))))(re.union (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" ""))))) (re.* (re.range "s" "s")))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "l" (seq.++ "t" (seq.++ "o" "")))))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" "")))))(re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" ""))))) (str.to_re (seq.++ "w" (seq.++ "e" (seq.++ "b" (seq.++ "c" (seq.++ "a" (seq.++ "l" ""))))))))))))(re.++ (re.range ":" ":") (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))) (re.++ (re.++ (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
