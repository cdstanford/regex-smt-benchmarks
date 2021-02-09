;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:\d|I{1,3})?\s?\w{2,}\.?\s*\d{1,}\:\d{1,}-?,?\d{0,2}(?:,\d{0,2}){0,2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00EDi\x3q\u00F6II Rm.\u00A0\u00A004:8-,"
(define-fun Witness1 () String (seq.++ "\xed" (seq.++ "i" (seq.++ "\x03" (seq.++ "q" (seq.++ "\xf6" (seq.++ "I" (seq.++ "I" (seq.++ " " (seq.++ "R" (seq.++ "m" (seq.++ "." (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "0" (seq.++ "4" (seq.++ ":" (seq.++ "8" (seq.++ "-" (seq.++ "," ""))))))))))))))))))))
;witness2: "IIv\u00E8\u00B5Z. 9982:9-,,\x5\u00BE"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "I" (seq.++ "v" (seq.++ "\xe8" (seq.++ "\xb5" (seq.++ "Z" (seq.++ "." (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ ":" (seq.++ "9" (seq.++ "-" (seq.++ "," (seq.++ "," (seq.++ "\x05" (seq.++ "\xbe" ""))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "0" "9") ((_ re.loop 1 3) (re.range "I" "I"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "," ","))(re.++ ((_ re.loop 0 2) (re.range "0" "9")) ((_ re.loop 0 2) (re.++ (re.range "," ",") ((_ re.loop 0 2) (re.range "0" "9")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
