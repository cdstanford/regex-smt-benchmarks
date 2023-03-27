;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = megaupload\.com.*(?:\?|&)(?:(?:folderi)?d|f)=([A-Z-a-z0-9]{8})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "megaupload.com`\u00A4\u0083\u00E3&f=-Aj9-5-j"
(define-fun Witness1 () String (str.++ "m" (str.++ "e" (str.++ "g" (str.++ "a" (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "`" (str.++ "\u{a4}" (str.++ "\u{83}" (str.++ "\u{e3}" (str.++ "&" (str.++ "f" (str.++ "=" (str.++ "-" (str.++ "A" (str.++ "j" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "-" (str.++ "j" ""))))))))))))))))))))))))))))))
;witness2: "Vmegaupload.com&f=aXW88PXZ"
(define-fun Witness2 () String (str.++ "V" (str.++ "m" (str.++ "e" (str.++ "g" (str.++ "a" (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "&" (str.++ "f" (str.++ "=" (str.++ "a" (str.++ "X" (str.++ "W" (str.++ "8" (str.++ "8" (str.++ "P" (str.++ "X" (str.++ "Z" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "m" (str.++ "e" (str.++ "g" (str.++ "a" (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" "")))))))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "&" "&") (re.range "?" "?"))(re.++ (re.union (re.++ (re.opt (str.to_re (str.++ "f" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ "e" (str.++ "r" (str.++ "i" ""))))))))) (re.range "d" "d")) (re.range "f" "f"))(re.++ (re.range "=" "=") ((_ re.loop 8 8) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
