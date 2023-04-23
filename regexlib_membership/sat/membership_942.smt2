;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(sip|sips)\:\+?([\w|\:?\.?\-?\@?\;?\,?\=\%\&]+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "sip:B"
(define-fun Witness1 () String (str.++ "s" (str.++ "i" (str.++ "p" (str.++ ":" (str.++ "B" ""))))))
;witness2: "sip:+3"
(define-fun Witness2 () String (str.++ "s" (str.++ "i" (str.++ "p" (str.++ ":" (str.++ "+" (str.++ "3" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "s" (str.++ "i" (str.++ "p" "")))) (str.to_re (str.++ "s" (str.++ "i" (str.++ "p" (str.++ "s" ""))))))(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "+" "+")) (re.+ (re.union (re.range "%" "&")(re.union (re.range "," ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
