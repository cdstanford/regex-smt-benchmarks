;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((?:[\\?&](?:[a-z\d\\.\\[\\]%-]+)(?:=[a-z\\d\\.\\[\\]%-]*)?)*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: "?[%-]=.%-"
(define-fun Witness2 () String (seq.++ "?" (seq.++ "[" (seq.++ "%" (seq.++ "-" (seq.++ "]" (seq.++ "=" (seq.++ "." (seq.++ "%" (seq.++ "-" ""))))))))))

(assert (= regexA (re.* (re.++ (re.union (re.range "&" "&")(re.union (re.range "?" "?") (re.range "\x5c" "\x5c")))(re.++ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "[" "\x5c") (re.range "a" "z"))))(re.++ (str.to_re (seq.++ "%" (seq.++ "-" "")))(re.++ (re.+ (re.range "]" "]")) (re.opt (re.++ (re.range "=" "=")(re.++ (re.union (re.range "." ".")(re.union (re.range "[" "\x5c") (re.range "a" "z")))(re.++ (str.to_re (seq.++ "%" (seq.++ "-" ""))) (re.* (re.range "]" "]")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
