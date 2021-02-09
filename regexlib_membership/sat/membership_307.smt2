;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^Content-Type:\s*(\w+)\s*/?\s*(\w*)?\s*;\s*((\w+)?\s*=\s*((".+")|(\S+)))?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Content-Type:\u0085 l98\u00A0/;\xC"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "-" (seq.++ "T" (seq.++ "y" (seq.++ "p" (seq.++ "e" (seq.++ ":" (seq.++ "\x85" (seq.++ " " (seq.++ "l" (seq.++ "9" (seq.++ "8" (seq.++ "\xa0" (seq.++ "/" (seq.++ ";" (seq.++ "\x0c" "")))))))))))))))))))))))
;witness2: "Content-Type:\u00AA9/;\u00A0\u00B5\u00D6= \"<\"l"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "-" (seq.++ "T" (seq.++ "y" (seq.++ "p" (seq.++ "e" (seq.++ ":" (seq.++ "\xaa" (seq.++ "9" (seq.++ "/" (seq.++ ";" (seq.++ "\xa0" (seq.++ "\xb5" (seq.++ "\xd6" (seq.++ "=" (seq.++ " " (seq.++ "\x22" (seq.++ "<" (seq.++ "\x22" (seq.++ "l" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "C" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "-" (seq.++ "T" (seq.++ "y" (seq.++ "p" (seq.++ "e" (seq.++ ":" ""))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.++ (re.opt (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.range "\x22" "\x22"))) (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
