;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:\d|I{1,3})?\s?\w{2,}\.?\s*\d{1,}\:\d{1,}-?,?\d{0,2}(?:,\d{0,2}){0,2}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00EDi\x3q\u00F6II Rm.\u00A0\u00A004:8-,"
(define-fun Witness1 () String (str.++ "\u{ed}" (str.++ "i" (str.++ "\u{03}" (str.++ "q" (str.++ "\u{f6}" (str.++ "I" (str.++ "I" (str.++ " " (str.++ "R" (str.++ "m" (str.++ "." (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "0" (str.++ "4" (str.++ ":" (str.++ "8" (str.++ "-" (str.++ "," ""))))))))))))))))))))
;witness2: "IIv\u00E8\u00B5Z. 9982:9-,,\x5\u00BE"
(define-fun Witness2 () String (str.++ "I" (str.++ "I" (str.++ "v" (str.++ "\u{e8}" (str.++ "\u{b5}" (str.++ "Z" (str.++ "." (str.++ " " (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ ":" (str.++ "9" (str.++ "-" (str.++ "," (str.++ "," (str.++ "\u{05}" (str.++ "\u{be}" ""))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "0" "9") ((_ re.loop 1 3) (re.range "I" "I"))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "," ","))(re.++ ((_ re.loop 0 2) (re.range "0" "9")) ((_ re.loop 0 2) (re.++ (re.range "," ",") ((_ re.loop 0 2) (re.range "0" "9")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
