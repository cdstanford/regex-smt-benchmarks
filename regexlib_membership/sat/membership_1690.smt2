;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[A-ZÀ-Ü]{1}[a-zà-ü']+\s[a-zA-Zà-üÀ-Ü]+((([\s\.'])|([a-zà-ü']+))|[a-zà-ü']+[a-zA-Zà-üÀ-Ü']+))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "I\u00F0\u00E4\u00ED\x9o\u00D7\u00E8\'\x4"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "\xf0" (seq.++ "\xe4" (seq.++ "\xed" (seq.++ "\x09" (seq.++ "o" (seq.++ "\xd7" (seq.++ "\xe8" (seq.++ "'" (seq.++ "\x04" "")))))))))))
;witness2: "E\u00E1\u00E1\'\'\u00A0x\u00E3\u00E9\u00EE\'\u00A1"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "\xe1" (seq.++ "\xe1" (seq.++ "'" (seq.++ "'" (seq.++ "\xa0" (seq.++ "x" (seq.++ "\xe3" (seq.++ "\xe9" (seq.++ "\xee" (seq.++ "'" (seq.++ "\xa1" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "\xc0" "\xdc"))(re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "a" "z") (re.range "\xe0" "\xfc"))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.+ (re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\xc0" "\xdc") (re.range "\xe0" "\xfc"))))) (re.union (re.union (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "." ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "a" "z") (re.range "\xe0" "\xfc"))))) (re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "a" "z") (re.range "\xe0" "\xfc")))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\xc0" "\xdc") (re.range "\xe0" "\xfc")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
