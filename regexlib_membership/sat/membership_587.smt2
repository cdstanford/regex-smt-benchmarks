;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<tagname>[^\s]*)="(?<tagvalue>[^"]*)"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u007F\u00A5=\"*\"\u00F2"
(define-fun Witness1 () String (seq.++ "\x7f" (seq.++ "\xa5" (seq.++ "=" (seq.++ "\x22" (seq.++ "*" (seq.++ "\x22" (seq.++ "\xf2" ""))))))))
;witness2: "\x1Fz\u0095\u00C6=\"\""
(define-fun Witness2 () String (seq.++ "\x1f" (seq.++ "z" (seq.++ "\x95" (seq.++ "\xc6" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" ""))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))(re.++ (str.to_re (seq.++ "=" (seq.++ "\x22" "")))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
