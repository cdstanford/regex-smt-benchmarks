;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = megaupload\.com.*(?:\?|&)(?:(?:folderi)?d|f)=([A-Z-a-z0-9]{8})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "megaupload.com`\u00A4\u0083\u00E3&f=-Aj9-5-j"
(define-fun Witness1 () String (seq.++ "m" (seq.++ "e" (seq.++ "g" (seq.++ "a" (seq.++ "u" (seq.++ "p" (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "`" (seq.++ "\xa4" (seq.++ "\x83" (seq.++ "\xe3" (seq.++ "&" (seq.++ "f" (seq.++ "=" (seq.++ "-" (seq.++ "A" (seq.++ "j" (seq.++ "9" (seq.++ "-" (seq.++ "5" (seq.++ "-" (seq.++ "j" ""))))))))))))))))))))))))))))))
;witness2: "Vmegaupload.com&f=aXW88PXZ"
(define-fun Witness2 () String (seq.++ "V" (seq.++ "m" (seq.++ "e" (seq.++ "g" (seq.++ "a" (seq.++ "u" (seq.++ "p" (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "&" (seq.++ "f" (seq.++ "=" (seq.++ "a" (seq.++ "X" (seq.++ "W" (seq.++ "8" (seq.++ "8" (seq.++ "P" (seq.++ "X" (seq.++ "Z" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "m" (seq.++ "e" (seq.++ "g" (seq.++ "a" (seq.++ "u" (seq.++ "p" (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" "")))))))))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "&" "&") (re.range "?" "?"))(re.++ (re.union (re.++ (re.opt (str.to_re (seq.++ "f" (seq.++ "o" (seq.++ "l" (seq.++ "d" (seq.++ "e" (seq.++ "r" (seq.++ "i" ""))))))))) (re.range "d" "d")) (re.range "f" "f"))(re.++ (re.range "=" "=") ((_ re.loop 8 8) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
