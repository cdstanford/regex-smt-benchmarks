;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (<b>)([^<>]+)(</b>)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "H[\u00A1\u00AEt<b>X</b>\x1C^<"
(define-fun Witness1 () String (seq.++ "H" (seq.++ "[" (seq.++ "\xa1" (seq.++ "\xae" (seq.++ "t" (seq.++ "<" (seq.++ "b" (seq.++ ">" (seq.++ "X" (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ ">" (seq.++ "\x1c" (seq.++ "^" (seq.++ "<" "")))))))))))))))))
;witness2: "<b>\u0087\u00EA</b>\u00D3\u00BE8"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "b" (seq.++ ">" (seq.++ "\x87" (seq.++ "\xea" (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ ">" (seq.++ "\xd3" (seq.++ "\xbe" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "b" (seq.++ ">" ""))))(re.++ (re.+ (re.union (re.range "\x00" ";")(re.union (re.range "=" "=") (re.range "?" "\xff")))) (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ ">" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
