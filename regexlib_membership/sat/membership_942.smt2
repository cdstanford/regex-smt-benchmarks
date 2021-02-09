;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(sip|sips)\:\+?([\w|\:?\.?\-?\@?\;?\,?\=\%\&]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "sip:B"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "i" (seq.++ "p" (seq.++ ":" (seq.++ "B" ""))))))
;witness2: "sip:+3"
(define-fun Witness2 () String (seq.++ "s" (seq.++ "i" (seq.++ "p" (seq.++ ":" (seq.++ "+" (seq.++ "3" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "s" (seq.++ "i" (seq.++ "p" "")))) (str.to_re (seq.++ "s" (seq.++ "i" (seq.++ "p" (seq.++ "s" ""))))))(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "+" "+")) (re.+ (re.union (re.range "%" "&")(re.union (re.range "," ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
