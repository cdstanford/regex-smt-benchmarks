;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^"[^"]+"$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\",\""
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "," (seq.++ "\x22" ""))))
;witness2: "\"\x18\""
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "\x18" (seq.++ "\x22" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.range "\x00" "!") (re.range "#" "\xff")))(re.++ (re.range "\x22" "\x22") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
